class CreateJoinTableAdmissionDoctor < ActiveRecord::Migration[7.0]
  def change
    create_join_table :admissions, :doctors do |t|
      # t.index [:admission_id, :doctor_id]
      # t.index [:doctor_id, :admission_id]
    end
  end
end
