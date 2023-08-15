using Genie, Genie.Renderer, Genie.Renderer.Html


route("/") do
  html("Hello World")
end

up(8000, async = true)
Base.JLOptions().isinteractive == 0 && wait()