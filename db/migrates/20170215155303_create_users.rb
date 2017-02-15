class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, index: true
      t.string :access_token
      t.string :avatar
      t.string :uid, index: true
      t.timestamps
    end
  end
end
