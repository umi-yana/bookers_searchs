class SearchsController < ApplicationController

  def search
    @model = params["search"]["model"] 
    #選択したmodelを@modelに代入
    @value = params["search"]["value"]
    #検索にかけた文字列@valueに代入
    @how = params["search"]["how"]
    #選択した検索方法howを@howに代入
    @datas = search_for(@how, @model, @value)
  
    #search_forの引数にインスタンス変数を定義
    #最後は@datas に結果が入る
  end
  

  private

  def match(model, value)                     #def search_forでhowがmatchだった場合の処理
    if model == 'user'                        
      User.where(name: value)                 
    elsif model == 'book'    
      Book.where(title: value)
    end
  end

  def forward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
  end

  def partical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, model, value) #検索方法ごとの条件 
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end
  
  
