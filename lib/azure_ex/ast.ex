defmodule AzureEx.AST do
  @moduledoc false

  @path_var_re ~r/\{([^\}]+)\}/

  defmacro defendpoint(name, raw_uri) do
    # 扫描原始 URI 中的路径变量
    r = Regex.scan(@path_var_re, raw_uri)
    # 处理并得到路径变量名称列表
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
      path_var_args_ast ++ [{:params, [], Elixir}]
    }

    # 使用变量分割 URI
    raw_segments = Regex.split(@path_var_re, raw_uri)

    unless length(raw_segments) == length(path_vars) + 1 do
      raise """
      Error parsing raw URI, wrong number of path variables.\n
      URI: #{raw_uri}
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

    # 函数体 AST（拼接字符串）
    fun_body_ast = {:<<>>, [], splicing_args_ast}

    quote do
      def unquote(fun_sign_ast) do
        unquote(fun_body_ast) <> "?" <> URI.encode_query(unquote({:params, [], Elixir}))
      end
    end
  end
end
