def consolidate_cart(cart)
  hash = {}
  cart.each do |item|
    item.each do |name, price|
      if hash[name].nil?
        hash[name] = price.merge({:count => 1})
      else
        hash[name][:count] += 1
      end
    end
  end
  return hash
end

#Apply_coupons was taken from the solutions branch (i'm glad I learned it exists only at the end of the precourse)
def apply_coupons(cart, coupons)
  new_cart=cart
  coupons.each do |coupon|
    name = coupon[:item]
    if new_cart[name] && new_cart[name][:count] >= coupon[:num]
      if new_cart["#{name} W/COUPON"]
        new_cart["#{name} W/COUPON"][:count] += 1
      else
        new_cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        new_cart["#{name} W/COUPON"][:clearance] = new_cart[name][:clearance]
      end
      new_cart[name][:count] -= coupon[:num]
    end
  end
  return new_cart
end


def apply_clearance(cart)
  cart.each do |name, stats|
    if stats[:clearance]
      new_price = stats[:price] * 0.8
      new_new_price = new_price.round(2)
      stats[:price] = new_new_price
    end
  end
  cart
end



  def checkout(cart, coupons)
  simple_cart = consolidate_cart(cart)
  cart_after_coupons = apply_coupons(simple_cart, coupons)
  final_cart = apply_clearance(cart_after_coupons)
  total = 0
  final_cart.each do |name, stats|
    total += stats[:price] * stats[:count]
  end
  if total > 100
    total = total * 0.9
  end
  return total
end
