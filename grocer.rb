require 'pry'

def consolidate_cart(cart)
  hash = {}
  cart.each_with_index do |items, index|
    #{"TEMPEH"=>{:price=>3.0, :clearance=>true}}
    items.each do |food, details|
      # puts "#{food}: #{details}"
      if hash[food]
        hash[food][:count] += 1
      else
        hash[food] = details
        hash[food][:count] = 1
      end
    end
  end
  hash
  # binding.pry
end

def apply_coupons(cart, coupons)
  result = {}
  cart.each do |food, details|
    #AVOCADO: {:price=>3.0, :clearance=>true, :count=>2}
    coupons.each do |coupon|

      if food == coupon[:item] && details[:count] >= coupon[:num]
        details[:count] = details[:count] - coupon[:num]
        if result["#{food} W/COUPON"]
          result["#{food} W/COUPON"][:count] += 1
        else
          result["#{food} W/COUPON"] = {
            :price => coupon[:cost],
            :clearance => details[:clearance],
            :count => 1
          }
          # result["#{food} W/COUPON"][:price] = coupon[:cost]
          # result["#{food} W/COUPON"][:clearance] = details[:clearance]
          # result["#{food} W/COUPON"][:count] = 1

        end
      end
    end
    #add the original food into the result
  result[food] = details
  end
  result
  # binding.pry
end

def apply_clearance(cart)
  result = {}
  cart.each do |food, details|
    # puts "#{food}: #{details}"
    result[food] = {}
    if details[:clearance] == true
      result[food][:price] = details[:price] * 4/5
    else
      result[food][:price] = details[:price]
    end
    result[food][:clearance] = details[:clearance]
    result[food][:count] = details[:count]
  end
  result
  # binding.pry
end

def checkout(cart, coupons)
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    cart = apply_clearance(cart)
    result = 0

    cart.each do |food, details|
      # puts "#{food}: #{details}"
      # puts details[:price]
      # puts details[:count]
      result += (details[:price] * details[:count])
    end
    result > 100 ? result * 0.9 : result
    # puts coupon[:price]

    # puts clearance[:price]
    # binding.pry
end
