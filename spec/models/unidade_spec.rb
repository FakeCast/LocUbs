require 'rails_helper'

RSpec.describe Unidade, type: :model do
  let(:url) { 'tmp/ubs.csv' }
  let(:wrong_url) { 'any_address' }

  before do
   u = Unidade.create name: 'US OSWALDO DE SOUZA', address: 'TV ADALTO BOTELHO', city: 'São Paulo', phone: '1234567', geocode_lat: '-10.911237', geocode_long: '-37.06207752', scores_size: '3', scores_adaptation_for_seniors: '3', scores_medical_equipment: '3', scores_medicine:'3'
   u = Unidade.create name: 'UNIDADE BASICA DE SAUDE 06 QA11 LESTE', address: 'TV ADALTO BOTELHO', city: 'São Paulo', phone: '1234567', geocode_lat: '-15.911237', geocode_long: '-47.06207752', scores_size: '3', scores_adaptation_for_seniors: '3', scores_medical_equipment: '3', scores_medicine:'3'
  end

  context 'when request show' do
    it 'should return the most closer UBS' do
      expect(subject.show('-15.453','-47.614')).to include("id")
    end
  end
  context 'when request refresh' do
    it 'should refresh the database using CSV file' do
      expect(subject.refresh(url)).to be(true)
    end
    it 'return error if file not found' do
      expect(subject.refresh(wrong_url)).to eq('File not found!')
    end
  end

  context 'calculate scores' do
    it 'when status is Desempenho muito acima da média' do
      expect(subject.score('Desempenho muito acima da média')).to eq(3)
    end
    it 'when status is Desempenho acima da média' do
      expect(subject.score('Desempenho acima da média')).to eq(2)
    end
    it 'when status is Desempenho muito acima da média' do
      expect(subject.score('Desempenho mediano ou  um pouco abaixo da média')).to eq(1)
    end
  end

end
