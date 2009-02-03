require 'activerecord'
require 'globalize/backend/static'

module Globalize
  module Backend
    class Database < Static
      def store_translations(locale, data)
        data.each { |key, text| Translation.create_or_update(locale, key, text) }
      end

      def translate(locale, key, options = {})
        # TODO default
        result = Translation.find_by_locale_and_key(locale, key).text rescue nil
        translation(result) || raise(I18n::MissingTranslationData.new(locale, key, options))
      end

      class Translation < ::ActiveRecord::Base
        set_table_name 'globalize_translations'
        
        class << self
          def create_or_update(locale, key, text)
            if record = find_by_locale_and_key(locale, key)
              record.update_attribute(:text, text)
            else
              create :locale => locale, :key => key, :text => text
            end
          end
        end
      end
    end
  end
end
