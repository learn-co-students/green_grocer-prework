def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |type, attributes| #enters loop
      if result[type]
        attributes[:count] += 1 # creates new variable and addes to it
      else
        attributes[:count] = 1
        result[type] = attributes # still adds new variable
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num] # if true, then applies coupon
      if cart["#{name} W/COUPON"] # creates new var that has effect of coupon
        cart["#{name} W/COUPON"][:count] += 1 #creates and adds count
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]} # creates coupon but unused
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num] # regardless of above, eh, applies effect of the coupon if any.
    end
  end
  cart # returns final version with coupon applied
end

def apply_clearance(cart)
  cart.each do |name, properties|
    if properties[:clearance] # checks for clearance
      updated_price = properties[:price] * 0.80
      properties[:price] = updated_price.round(2) #adding new price value in place
    end
  end
  cart # return new cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end
