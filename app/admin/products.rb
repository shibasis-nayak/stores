ActiveAdmin.register Product do

  permit_params :description, :name, :price, :category_id

end