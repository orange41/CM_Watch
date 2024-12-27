class AddOriginalIncidentIdToIncidents < ActiveRecord::Migration[6.1]
  def change
    add_reference :incidents, :original_incident, foreign_key: { to_table: :incidents }
  end
end
