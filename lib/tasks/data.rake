require 'csv'
namespace :data do
  
  desc "Populate data into db"
  task :populate_data => :environment do
    taxonomy = Spree::Taxonomy.find_by(name: "Category")
    taxonomy ||= Spree::Taxonomy.create!(name: "Category")
    parent_id = taxonomy.taxons.root.id
    count = 0
    array = []
    CSV.foreach('/home/inveera/lbl/data/lbl_data_file_new.csv',  :headers=>true) do |row|
      #next if row['model_number'].nil?
      taxon = taxonomy.taxons.find_by(name: row['product_category'])      
      taxon ||= taxonomy.taxons.create(name: row['product_category'], parent_id: parent_id) 
      #model_number = "#{row['model_number']}-#{count}"
      product = Spree::Product.find_by(model_number: row['model_number'])
      if product.present?
        next
      else
        product = Spree::Product.create(model_number: row['model_number'],name: row['product_name'],price: rand(100..2000), shipping_category_id: 1, available_on: Date.today, description: row['description'])
      end
      taxon.products << product
      puts "Number of product created: #{count}"
      count +=1
    end
    puts "total: #{array.count}"
    puts "total unique: #{array.count}"
  end
  task :populate_images => :environment do
    puts "Product images uploading..."
    CSV.foreach('/home/inveera/lbl/data/lineart_image_file_new.csv',  :headers=>true) do |row|
      product = Spree::Product.find_by(model_number: row['model_number'].gsub(/\u00a0/, ''))
      #next if product.id <= 92 
      puts "#{product.slug}"
      #puts row['image_url']
      Spree::Image.create!(:attachment => open(URI.parse(row['image_url'])), :viewable => product.master)
    end
  end
  task :update_permalink => :environment do
    taxonomy = Spree::Taxonomy.find_by(name: "LBL Lighting")
    puts "Permalink updating..."
    taxonomy.root.children.each do |taxon|
      permalink = taxon.permalink.gsub("category","lbl-lighting")
      taxon.permalink = permalink
      taxon.save
    end
  end

  task :populate_specs => :environment do
    puts "Product specs updating..."
    CSV.foreach('/home/inveera/lbl/data/lbl_specs.csv',  :headers=>true) do |row|
      model_number = row['model_number'].gsub(/\u00a0/, '')
      product = Spree::Product.find_by(model_number: model_number)
      str = row['product_specs'].gsub('"',"")
      size = str.size
      str.slice!(size-1)
      str.slice!(0)
      arr = str.split(",")
      arr.shift
      product.specs[str.split(",")[0]] = arr
      product.save
      puts product.model_number
    end
  end

end