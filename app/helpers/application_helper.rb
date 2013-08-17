module ApplicationHelper

  def time_input(name, default = nil, options={})
    return select_tag(name,
      options_for_select((0...(24*3600)).step(15*60).to_a.map{
        |s| [Time.at(s - 3600).strftime("%H:%M"), s]
    }, selected: default), options.merge({include_blank: true}))
  end

  def bitmask_time_input name, day, default = nil
    return select_tag name,
      options_for_select((0...(24*3600))
        .step(15*60).to_a.map.with_index{
        |s,index| [Time.at(s - 3600).strftime("%H:%M"), index + (day * 96)]
    }, selected: default), include_blank: true
  end

  def title(page_title, options={})
    content_for(:title, page_title.to_s)
    return content_tag(:h1, page_title, options)
  end

end
