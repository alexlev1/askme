class AddHeaderStyleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :header_style, :string
  end
end
