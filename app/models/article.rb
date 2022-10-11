class Article < ApplicationRecord

    accepts_nested_attributes_for :author, :pages
    
end
