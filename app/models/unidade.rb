class Unidade < ActiveRecord::Base
  require 'csv'
  require 'open-uri'
  def show(lat, lon)
    unidade = Unidade.connection.select_all("SELECT *, ( 6371 * acos( cos( radians(#{lat}) ) * cos( radians( geocode_lat ) ) *
    cos( radians( geocode_long ) - radians(#{lon}) ) + sin( radians(#{lat}) ) *
    sin( radians( geocode_lat ) ) ) ) AS distance FROM unidades ORDER BY distance LIMIT 1, 20;").to_hash[0]
    result = Hash.new
    result = {
      "id" => unidade["id"],
      "name" => unidade["name"],
      "address" => unidade["address"],
      "city" => unidade["city"],
      "phone" => unidade["phone"],
      "geocode.lat" => unidade["geocode_lat"],
      "geocode.long" => unidade["geocode_long"],
      "scores.size" => unidade["scores_size"],
      "scores.adaptation_for_seniors" => unidade["adaptation_for_seniors"],
      "scores.medical_equipment" => unidade["medical_equipment"],
      "scores.medicine" => unidade["scores_medicine"]
    }
  end

  def score(element)
    if element == "Desempenho muito acima da média"
      return 3
    elsif element == "Desempenho acima da média"
      return 2
    elsif element == "Desempenho mediano ou  um pouco abaixo da média"
      return 1
    end
  end

  def refresh(url)
    Unidade.delete_all
    open(url) do |f|
      f.each_line do |l|
        CSV.parse(l) do |row|
          unidade = Unidade.new do | u |
            u.name = row[4]
            u.address = "#{row[5]} - Bairro: #{row[6]}"
            u.city = row[7]
            u.phone = row[8]
            u.geocode_lat = row[0]
            u.geocode_long = row[1]
            u.scores_size = score(row[9])
            u.scores_adaptation_for_seniors = score(row[10])
            u.scores_medical_equipment = score(row[11])
            u.scores_medicine = score(row[12])
          end
          unidade.save!
        end
      end
      return true
    end
  rescue
    return "File not found!"
  end
end
