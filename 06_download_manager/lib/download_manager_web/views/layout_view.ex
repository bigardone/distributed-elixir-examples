defmodule DownloadManagerWeb.LayoutView do
  use DownloadManagerWeb, :view

  def placeholder(opts \\ []) do
    class = Keyword.get(opts, :class, "")
    max_length = Keyword.get(opts, :max_length, 5)
    height = Keyword.get(opts, :height, 2)
    color = Keyword.get(opts, :color, "bg-gray-400")
    width = Keyword.get(opts, :width, Enum.random(1..max_length))

    content_tag(:div, "",
      class: "rounded-full h-#{height} #{color} w-#{width}/12 hover:bg-gray-400 #{class}"
    )
  end

  def placeholder_paragraph(length \\ 5) do
    content_tag :div, class: "flex h-4 w-full gap-x-4 items-center" do
      for _ <- 1..length do
        placeholder(5)
      end
    end
  end
end
