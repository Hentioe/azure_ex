defmodule AzureEx.DSL do
  @moduledoc false

  @path_var_re ~r/\{([^\}]+)\}/
  @api_version_query_re ~r/api\-version=(.+)$/

  defmacro defendpoint(name, raw_api) do
    # 解析并获取请求方法
    method_s = raw_api |> String.split(" ") |> List.first() |> Macro.underscore()

    # +1 是为了消除空格
    uri_begin_pos = String.length(method_s) + 1

    method = String.to_atom(method_s)
    # 解析并获取 API 版本
    [_, api_version] = Regex.run(@api_version_query_re, raw_api)

    [{query_begin_pos, _}, _] = Regex.run(@api_version_query_re, raw_api, return: :index)

    # 截断获取 URI
    uri = String.slice(raw_api, uri_begin_pos..(query_begin_pos - 2))

    # 扫描 URI 中的路径变量
    r = Regex.scan(@path_var_re, uri)
    # 处理并得到路径变量的名称列表
    path_vars =
      r
      |> Enum.map(&List.last/1)
      |> Enum.map(&Macro.underscore/1)

    # 路径变量列表对应的参数 AST
    path_var_args_ast =
      path_vars
      |> Enum.map(fn var_name -> {String.to_atom(var_name), [], Elixir} end)

    # 函数签名 AST
    fun_sign_ast = {
      String.to_atom(Macro.underscore(name)),
      [],
      path_var_args_ast ++ [{:\\, [], [{:options, [], Elixir}, []]}]
    }

    # 使用变量分割 URI
    raw_segments = Regex.split(@path_var_re, uri)

    unless length(raw_segments) == length(path_vars) + 1 do
      raise """
      Error parsing raw URI, wrong number of path variables.\n
      URI: #{uri}
      Vars: #{inspect(path_vars)}
      """
    end

    # <<>> 宏的参数 AST
    splicing_args_ast =
      raw_segments
      |> Enum.with_index()
      |> Enum.reduce([], fn {seg, i}, acc ->
        acc = acc ++ [seg]

        if var = Enum.at(path_vars, i) do
          var_ast =
            {:"::", [],
             [
               {{:., [], [Kernel, :to_string]}, [], [{String.to_atom(var), [], Elixir}]},
               {:binary, [], Elixir}
             ]}

          acc ++ [var_ast]
        else
          acc
        end
      end)

    # <<>> 宏的调用 AST
    splicing_call_ast = {:<<>>, [], splicing_args_ast}

    quote do
      def unquote(fun_sign_ast) do
        api_version =
          Keyword.get(unquote({:options, [], Elixir}), :"api-version", unquote(api_version))

        params = Keyword.get(unquote({:options, [], Elixir}), :params)
        data = Keyword.get(unquote({:options, [], Elixir}), :data)

        endpoint = unquote(splicing_call_ast) <> "?" <> "api-version=#{api_version}"

        endpoint =
          if params do
            endpoint <> "&#{URI.encode_query(params)}"
          else
            endpoint
          end

        AzureEx.Request.call(endpoint, unquote(method), data)
      end
    end
  end
end
