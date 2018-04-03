def consolidate_cart(cart)
  # code here
  new_hash_cart = {}
  cart.each do |item|
      #item[:count] = 0
      #binding.pry
      item.each do |test, values|
          if new_hash_cart.keys.include?(test)
              new_hash_cart[test][:count] += 1
          else
                new_hash_cart[test] = values
               new_hash_cart[test][:count] = 1
              end
          # binding.pry
#    item.each do |test_two, values_two|
#    if new_hash_cart
#        new_hash_cart
#        values_two[:count] += 1 if
        #binding.pry
          end
      end
  new_hash_cart
  # binding.pry
end

#(result["AVOCADO"][:price]).to eq(3.00)
def apply_coupons(cart, coupons)
cart.each do |keys, info|
    coupons.each do |coupon|
        #binding.pry
        item = coupon[:item]
        cost = coupon[:cost]
        number_discounts = coupon[:num]
        if item == keys && cart["#{keys} W/COUPON"] == nil && cart[keys][:count] >= number_discounts
            cart[keys][:count] -= number_discounts
            cart = cart.clone
            #binding.pry
            cart["#{keys} W/COUPON"] = {
                :price => cost,
                :clearance => cart[keys][:clearance],
                :count => 1
            }
            elsif item == keys && cart[keys][:count] >= number_discounts
            cart[keys][:count] -= number_discounts
            cart["#{keys} W/COUPON"][:count] += 1
            end
        #binding.pry
        end
    end
cart
#binding.pry
end

def apply_clearance(cart)
  # code here
  cart.each do |keys, values|
      values[:price] = 0.8 * values[:price] if values[:clearance] == true
      values[:price] = values[:price].round(2)
      end
  cart
end

def checkout(cart, coupons)
  # code here
 cart = consolidate_cart(cart)
 cart = apply_coupons(cart, coupons)
 cart = apply_clearance(cart)
 total = 0.to_f
    cart.each do |keys, values|
        total += (values[:price] * values[:count])
        #binding.pry
        end
    total = (total * 0.9) if total > 100
    total
end
