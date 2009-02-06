ActiveRecord::Schema.define do
  
  create_table :blogs, :force => true do |t|
  end

  create_table :posts, :force => true do |t|
    t.references :blog
  end

  create_table :post_translations, :force => true do |t|
    t.string     :locale
    t.references :post
    t.string     :subject
    t.text       :content
  end
  
  create_table :globalize_translations, :force => true do |t|
    t.string :key, :null => false
    t.string :locale, :null => false
    t.string :pluralization_index, :null => false
    t.string :text
  end
  
  # TODO enable index
  # add_index :globalize_translations, [ :key, :locale, :pluralization_index ], :unique => true
end
  
