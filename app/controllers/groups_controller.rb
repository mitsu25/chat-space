class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    binding.pry
  end
end
