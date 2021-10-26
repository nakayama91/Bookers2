class SearchsController < ApplicationController

  def search
    @model = params["model"]  #選択したmodelの値を@modelに代入
    @content = params["content"]  #選択した検索ワードを@contentに代入
    @method = params["method"]  #選択した検索方法の値を@methodに代入
    @records = search_for(@model, @content, @method) #@model,@content,@methodを代入したsearch_forを@recordsに代入
  end

  private

  def search_for(model, content, method)
    if model == 'user'  #選択したモデルがuserだったら
      if method == 'perfect'  #選択した検索方法が完全一致だったら
        User.where(name: content)
      elsif method == 'partial'  #選択した検索方法が部分一致だったら
        User.where('name Like ?', '%'+content+'%')
      elsif method == 'forward' #選択した検索方法が前方一致だったら
        User.where('name Like?', content+'%')
      elsif method == 'backward'  #選択した検索方法が後方一致だったら
        User.where('name Like?', '%'+content )
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'partial'
        Book.where('title Like ?', '%'+content+'%')
      elsif method == 'forward'
        Book.where('title Like ?', content+'%')
      elsif method == 'backward'
        Book.where('title Like ?', '%'+content )
      end
    end
  end

end