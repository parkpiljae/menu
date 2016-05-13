
require 'wombat'
require 'nokogiri'
require 'open-uri'

class HomeController < ApplicationController
  def index
  	
  	doc = Nokogiri::HTML(open("http://m.sejong.ac.kr/front/cafeteria.do?type1=3"))
  	
    
    @date =doc.css('tr .th').children[3*1].text[2..-2].to_date
    @type =doc.css('tr .th').children[3*1+1].text
    @food =doc.css('.td')[2*1].children.text
    
    @chan = Chan.all
  	@gun =  Gun.all
    @gun_num = Gun.where(gun_date: '2016-05-09',gun_type: '중식')



  end
  
  def crawl
    doc = Nokogiri::HTML(open("http://m.sejong.ac.kr/front/cafeteria.do?type1=1"))
    doc2 = Nokogiri::HTML(open("http://m.sejong.ac.kr/front/cafeteria.do?type1=3")) 
      
      for i in 0..5
        chan= Chan.new
        chan.chan_date =doc.css('tr .th').children[3*i].text[2..-2].to_date.to_s
        chan.chan_type =doc.css('tr .th').children[1].text
        chan.food =doc.css('.td')[2*i].children.text
        chan.save

        gun = Gun.new
        gun.gun_date =doc2.css('tr .th').children[3*i].text[2..-2].to_date.to_s
        gun.gun_type =doc2.css('tr .th').children[1].text
        gun.food =doc2.css('.td')[2*i].children.text
        gun.save

      end
      
      (0..5).each do |i|
        chan= Chan.new
        chan.chan_date =doc.css('tr .th').children[3*i].text[2..-2].to_date.to_s
        chan.chan_type =doc.css('tr .th').children[2].text
        chan.food =doc.css('.td')[2*i+1].children.text
        chan.save
        gun= Gun.new
        gun.gun_date =doc2.css('tr .th').children[3*i].text[2..-2].to_date.to_s
        gun.gun_type =doc2.css('tr .th').children[2].text
        gun.food =doc2.css('.td')[2*i+1].children.text
        gun.save
      end
      

    redirect_to :back
  end
  def destroy
     Gun.destroy_all
     Chan.destroy_all

    redirect_to :back

  end
  def update
    doc = Nokogiri::HTML(open("http://m.sejong.ac.kr/front/cafeteria.do?type1=1"))
    doc2 = Nokogiri::HTML(open("http://m.sejong.ac.kr/front/cafeteria.do?type1=3"))

    (1..6).each do |t|
      chan = Chan.find(t)
      chan.chan_date =doc.css('tr .th').children[3*t-3].text[2..-2].to_date
      chan.chan_type =doc.css('tr .th').children[1].text
      chan.food =doc.css('.td')[2*t-2].children.text
      chan.save

      gun = Gun.find(t)
      gun.gun_date =doc2.css('tr .th').children[3*t-3].text[2..-2].to_date
      gun.gun_type =doc2.css('tr .th').children[1].text
      gun.food =doc2.css('.td')[2*t-2].children.text
      gun.save


    end
    (7..12).each do |t|
      chan = Chan.find(t)
      chan.chan_date =doc.css('tr .th').children[3*t-21].text[2..-2].to_date
      chan.chan_type =doc.css('tr .th').children[2].text
      chan.food =doc.css('.td')[2*t-13].children.text
      chan.save

      gun = Gun.find(t)
      gun.gun_date =doc2.css('tr .th').children[3*t-21].text[2..-2].to_date
      gun.gun_type =doc2.css('tr .th').children[2].text
      gun.food =doc2.css('.td')[2*t-13].children.text
      gun.save


    end


    redirect_to :back
  end
end
