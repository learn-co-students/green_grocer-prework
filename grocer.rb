require 'pry'

def consolidate_cart(original_cart)

consolidated_hash = {}

  original_cart.each do |hashes|

    hashes.each do |food_name, details|

      if !consolidated_hash.include?(food_name)

      consolidated_hash[food_name] = details
      consolidated_hash[food_name][:count] = 1

      elsif consolidated_hash.include?(food_name)
      consolidated_hash[food_name][:count] +=1

      end

    end

  end
consolidated_hash

end

def apply_coupons(consolidated_hash, coupon)

coupon_hash = {}

#binding.pry

 coupon.each do |element|

     element.each do |coupon_key, coupon_values|


       consolidated_hash.each do |food_name, food_hash|


         if coupon_values == food_name && element[:num] <= consolidated_hash[food_name][:count]



           name_with_discount = food_name + " W/COUPON"

           coupon_hash[name_with_discount] = {:price =>element[:cost], :clearance => consolidated_hash[food_name][:clearance], :count => (consolidated_hash[food_name][:count]/ element[:num]) }


           consolidated_hash[food_name][:count] =  (consolidated_hash[food_name][:count] % element[:num])




           end
         end
       end
 end

 consolidated_hash.merge!(coupon_hash)
end

def apply_clearance(cart)
  # code here
  cart.each do |food_key, food_values_hash|

    food_values_hash.each do |price_clearance_count, values|

      if cart[food_key][price_clearance_count] == true
      cart[food_key][:price] = (cart[food_key][:price] - (cart[food_key][:price] * 0.2))
      end
    end

  end


end



def checkout( cart, coupons)

  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0

  cart.each do |foods, food_values_hash|
    total +=(food_values_hash[:price] * food_values_hash[:count])
  end


  if total > 100.0
    total = (total - (total * 0.1))
  end
total
end
