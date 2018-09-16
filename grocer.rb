  def consolidate_cart(cart)
  newcart = {}
  cart.each do |hash_product|
    hash_product.each do |name, hash_data|
      if hash_product[name] == newcart[name]
        newcart[name][:count] += 1
      else
        newcart[name] = hash_data
        newcart[name][:count] = 1
      end
    end
  end
  newcart
end

def apply_coupons(cart, coupons)
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
  cart.each do |name, info|
    if info[:clearance] == true
      info[:price] = info[:price] - info[:price] * 0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
 	 cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each {|grocery,value| total += (cart[grocery][:price] * cart[grocery][:count]) if cart[grocery][:count] > 0}
  total > 100 ? (total*0.9).round(2) : total
end
