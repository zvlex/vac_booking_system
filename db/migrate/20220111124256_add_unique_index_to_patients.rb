class AddUniqueIndexToPatients < ActiveRecord::Migration[6.1]
  def change
    add_index :patients, [:first_name, :last_name, :pin, :birth_date], unique: true, where: 'non_resident = false', name: 'unique_patient_index' 
  end
end
