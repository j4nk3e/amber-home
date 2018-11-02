require "adamite"

class BridgeController < ApplicationController
  before_action do
    only [:get, :create, :toggle, :scene] {
      id = params[:id]
      reg = Registration.first("WHERE internal_id = ?", id)
      if reg
        if reg.username
          @bridge = Bridge.new id, reg.address!, reg.username!
        else
          @bridge = Bridge.new id, reg.address!, reg.username!
        end
      else
        flash.alert = "ID not found"
      end
    }
  end

  def index
    bridges = begin
      Adamite.discover
    rescue exception
      flash.alert = "Error on registration: #{exception}"
      [] of Bridge
    end
    session[:bridges] = bridges
    bridges.each do |b|
      reg = Registration.first("WHERE internal_id = ?", b.id) || Registration.new
      reg.internal_id = b.id
      reg.address = b.internalipaddress
      reg.save
    end
    render "index.slang"
  end

  def rooms
    bridge.request_groups.to_a.select { |id, g| g.type == "Room" }
  end

  def scenes
    bridge.request_scenes.to_a.select { |id, s| !s.recycle }
  end

  def scene
    id = params[:scene]
    bridge.set_scene id
    redirect_to(:get, params: { "id" => params[:id] })
  end

  def get
    render "detail.slang"
  end

  def toggle
    id = params[:light]
    if light = bridge.request_light_info(id)
      if state = light.state
        bridge.set_light_state id, LightState.new !state.on
      end
    end
    redirect_to(:get, params: { "id" => params[:id] })
  end

  private def bridge
    @bridge || raise "Not found"
  end

  def create
    begin
      if user = bridge.register
        reg = Registration.first!("WHERE internal_id = ?", params[:id])
        reg.username = user
        reg.save
        flash.notice = "Registration success"
        render("detail.slang")
      else
        flash.alert = "Registration failed"
      end
    rescue e
      flash.alert = "Registration failed with error: #{e}"
      redirect_to(:index)
    end
  end
end
