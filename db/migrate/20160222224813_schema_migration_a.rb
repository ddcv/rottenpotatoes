class SchemaMigrationA < ActiveRecord::Migration
  def up
    add_column 'moviegoers', 'first_name', :string
    add_column 'moviegoers', 'last_name', :string
    add_column 'moviegoers', 'migrated', :boolean
    add_index 'moviegoers', 'migrated'
  end
end
