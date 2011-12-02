class AddPlazoAsignacion < ActiveRecord::Migration
  def self.up
 		add_column :asignacions,:plazo,:integer
	 end

  def self.down
		remove_column :asignacions,:plazo
  end
end
