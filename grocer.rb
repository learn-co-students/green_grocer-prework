def consolidate_cart(cart)
  output_hash = {}
  
  cart.each do |el|
    el.each do |name, values|
      if !output_hash[name]
        output_hash[name] = values
        output_hash[name].merge!(count: 1)
      else
        output_hash[name][:count] += 1
      end
    end
  end
  output_hash
end

def apply_coupons(cart, coupons)
  cart.map do |cart_item, details|
    puts coupons
    puts "NAMEEEE: #{coupons["num".to_sym]} Extra text"
    if coupons[:item] == cart_item
      coupon_count = coupons[:num] > cart_item[:count] ? cart_item[:count] : coupons[:num]
      cart["#{cart_item} W/COUPON"] = {
        price: coupons[:cost],
        clearance: true,
        count: coupon_count
      }
      
      cart_item[:count] -= coupon_count
    end
  end
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
