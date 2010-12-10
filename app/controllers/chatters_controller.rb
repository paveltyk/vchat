class ChattersController < ApplicationController
  def lookup
    chatter_identity = params[:chatter_identity]
    @chatter = Chatter.exclude_identity(chatter_identity).first
    if @chatter
      @chatter.delete
    else
      Chatter.create :identity => chatter_identity
    end
    respond_to do |format|
      format.xml
    end
  end
end
