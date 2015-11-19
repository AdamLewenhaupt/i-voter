class AuthController < ApplicationController

    def distance loc1, loc2
        rad_per_deg = Math::PI/180  # PI / 180
        rkm = 6371                  # Earth radius in kilometers
        rm = rkm * 1000             # Radius in meters

        dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
        dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

        lat1_rad, _ = loc1.map {|i| i * rad_per_deg }
        lat2_rad, _ = loc2.map {|i| i * rad_per_deg }

        a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

        rm * c # Delta in meters
    end

    def verify 

        @acc = params[:acc].to_f
        @lat = params[:lat].to_f
        @long = params[:long].to_f

        @dist = distance [$LAT, $LONG], [@lat, @long]

        @safeZone = 500

        #if @acc <= @safeZone
        if true
            #@auth = @dist - @acc <= @safeZone
            @auth = true
        else
            @auth = false  
        end

        render :json => { :auth => @auth }
    end
end
