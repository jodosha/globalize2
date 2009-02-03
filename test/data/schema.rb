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
    # TODO pluralization index
    t.string :text
  end
  
  # TODO add unique key for key and locale combination
  add_index :globalize_translations, :key
end
  
