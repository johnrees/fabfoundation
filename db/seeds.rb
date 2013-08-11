# ToolType.delete_all
# %w(laser_engraving 3d_printing cnc_router precision_cnc robot vinyl_cutting).each do |type|
#   ToolType.create!(name: type.humanize.capitalize, slug: type)
# end

# User.delete_all
# User.create!(first_name: 'John', last_name: 'Rees', admin: true, email: 'john@bitsushi.com', password: 'password')
# User.create!(first_name: 'Joe', last_name: 'Public', email: 'regular@mail.com', password: 'password')

Lab.delete_all
Lab.after_save.clear
# Lab.skip_callback(:create)
labs = JSON.parse( File.read('public/oldlabs.json') )
labs.each do |lab|
  if lab['address'].present?
    Lab.create(
      name: lab['name'],
      street_address_1: lab['address']['building'],
      city: lab['address']['city'],
      country_code: lab['address']['country'].downcase,
      latitude: lab['address']['latitude'],
      longitude: lab['address']['longitude'],
      urls: (lab['websites'].map{|m| m['url']}.join("\n") if lab['websites']),
      kind: Lab::Kinds.index(lab['kind'] == "fab_lab" ? lab['kind'] : "#{lab['kind']}_fab_lab")
    )
  end
end
