cart = [
  # {"AVOCADO" => {:price => 3.00, :clearance => true}},
  # {"KALE" => {:price => 3.00, :clearance => false}},
  # {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
  # {"ALMONDS" => {:price => 9.00, :clearance => false}},
  # {"TEMPEH" => {:price => 3.00, :clearance => true}},
  # {"CHEESE" => {:price => 6.50, :clearance => false}},
  # {"BEER" => {:price => 13.00, :clearance => false}},
  # {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
  # {"BEETS" => {:price => 2.50, :clearance => false}},
  # {"AVOCADO" => {:price => 3.00, :clearance => true}},
  # {"AVOCADO" => {:price => 3.00, :clearance => true}}
  {"BEER" => {:price => 13.00, :clearance => false}},
  {"BEER" => {:price => 13.00, :clearance => false}},
  {"BEER" => {:price => 13.00, :clearance => false}}
]

coupons = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
]

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |items|
    items.each do |item_name, item_stats|
      if new_cart.has_key?(item_name)
        new_cart[item_name][:count] += 1
      else
        new_cart[item_name] = item_stats
        new_cart[item_name][:count] = 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    coupon.each do |coupon_att, coupon_value|
      if cart.has_key?("#{coupon_value} W/COUPON")
        cart["#{coupon_value} W/COUPON"][:count] += 1
        cart[coupon_value][:count] -= coupon[:num]
      elsif cart.has_key?(coupon_value)
        cart["#{coupon_value} W/COUPON"] = {}
        cart["#{coupon_value} W/COUPON"][:price] = coupon[:cost]
        cart["#{coupon_value} W/COUPON"][:clearance] = cart[coupon_value][:clearance]
        cart[coupon_value][:count] -= coupon[:num]
        cart["#{coupon_value} W/COUPON"][:count] = 1
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_name, item_value|
    if item_value[:clearance] == true
      item_value[:price] -= item_value[:price] / 100 * 20
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  cart = consolidate_cart(cart)

  cart = apply_coupons(cart, coupons)

  cart.each do |item_name, item_value|
    # puts item_name
    puts cart[item_name][:count]
    if cart[item_name][:count] < 0
      cart[item_name][:count] += cart["#{item_name} W/COUPON"][:count]
      cart["#{item_name} W/COUPON"][:count] -= 1
    end
  end

  cart = apply_clearance(cart)
  cart.each do |item_name, item_value|
    total += cart[item_name][:price] * cart[item_name][:count]
  end
  if total > 100
    total -= total / 100 * 10
  end
  total
end

# puts consolidate_cart(cart)
# puts apply_coupons(consolidate_cart(cart), coupons)
# puts apply_clearance(consolidate_cart(cart))
puts checkout(cart, coupons)
