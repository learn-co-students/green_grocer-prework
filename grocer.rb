def consolidate_cart(cart)
  hash = {}
  cart.each do |item_hash|
    item_hash.each do |name, price_hash|
      if hash.include?(name)
        hash[name][:count] += 1
      else
        hash[name] = {:price => price_hash[:price], :clearance => price_hash[:clearance], :count => 1}
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  # code here
  result = {}
    cart.each do |food, info|
        coupons.each do |coupon|
          if food == coupon[:item] && info[:count] >= coupon[:num]
            info[:count] =  info[:count] - coupon[:num]
            if result["#{food} W/COUPON"]
              result["#{food} W/COUPON"][:count] += 1
            else
              result["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
            end
        end
      end
      result[food] = info
  end
result
end

def apply_clearance(cart)
  # code here
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
  # code here
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)

  total = 0

  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end

  total > 100 ? total * 0.9 : total

end
