class CreateJustificacionsLeyAcuerdos < ActiveRecord::Migration
  def self.up
  	create_table :justificacions_ley_acuerdos,:id => false do |t|
		t.integer :justificacion_id
		t.integer :ley_acuerdo_id
	end
  end

  def self.down
	drop_table :justificacions_ley_acuerdos
  end
end
