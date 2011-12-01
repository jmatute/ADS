class AddExpedienteJustificacion < ActiveRecord::Migration
  def self.up
	add_column :justificacions, :expediente_id,:integer

  end

  def self.down
	remove_column :justificaciones,:expediente_id
  end
end
