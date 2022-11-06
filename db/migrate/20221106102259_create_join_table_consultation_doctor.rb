class CreateJoinTableConsultationDoctor < ActiveRecord::Migration[7.0]
  def change
    create_join_table :consultations, :doctors do |t|
      # t.index [:consultation_id, :doctor_id]
      # t.index [:doctor_id, :consultation_id]
    end
  end
end
