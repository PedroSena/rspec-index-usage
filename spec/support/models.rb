require 'active_record'

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.index :email
    end
  end
end

class User < ActiveRecord::Base; end