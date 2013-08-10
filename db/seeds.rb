ToolType.delete_all
%w(laser_engraving 3d_printing cnc_router precision_cnc robot vinyl_cutting).each do |type|
  ToolType.create!(name: type.humanize.capitalize, slug: type)
end

User.delete_all
User.create!(first_name: 'John', last_name: 'Rees', admin: true, email: 'john@bitsushi.com', password: 'password')
User.create!(first_name: 'Joe', last_name: 'Public', email: 'regular@mail.com', password: 'password')

Lab.delete_all
Lab.after_save.clear
labs = JSON.parse( File.read('labs.json') )
labs.each do |lab|
  Lab.create!(
    name: lab['name'],
    country_code: lab['address']['country_code'],
    address: lab['address']['formatted'],
    latitude: lab['address']['latitude'],
    longitude: lab['address']['longitude'],
    urls: (lab['websites'].map{|m| m['url']}.join("\n") if lab['websites']),
    kind: [(lab['kind'] == "fab_lab" ? lab['kind'] : "#{lab['kind']}_fab_lab")]
  )
end
