def consolidate_cart(cart)
  ericCart = {}
  cart.each do |itemList|
    itemList.each do |key ,item|
      ericCart[key] ||= item
      ericCart[key][:count] = ericCart[key].has_key?(:count) ? ericCart[key][:count] + 1 : 1
    end
  end
  ericCart
  end 
 

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |name, properties|
    if properties[:clearance]
      cheap=properties[:price] *0.8
      properties[:price] = cheap.round(2)
    end
  end
end

def checkout(cart, coupons)
  concart = consolidate_cart(cart)
  coupeCart = apply_coupons(concart, coupons)
  finCart = apply_clearance(coupeCart)
  total = 0
  finCart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end
