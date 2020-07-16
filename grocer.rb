require 'pry'

def consolidate_cart(cart)
  consolidated = {}
  cart.each do |array|
    array.each do |food_key, data|
      if consolidated.include?(food_key)
        consolidated[food_key][:count] += 1
      else
        consolidated[food_key] = {
            :price => data [:price],
            :clearance => data[:clearance],
            :count => 1
        }
      end
    end
  end
consolidated
end

def apply_coupons(cart, coupons)
  couponed = {}

  cart.each do |food, data|
    couponed[food] = data

    coupons.each do |hash|

      if food == hash[:item]

        if data[:count] >= hash[:num]
          data[:count] -= hash[:num]

          if couponed.include?(food+" W/COUPON")
            couponed[food+" W/COUPON"][:count] += 1
          else
            couponed[food+" W/COUPON"] = {
                :price => hash[:cost],
                :clearance => data[:clearance],
                :count => 1
            }
          end
        end
      end
    end
  end

  couponed
end

def apply_clearance(cart)
  cart.each do |food_key,data|
    if data[:clearance] == true
      data[:price] = (data[:price]* 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0.00

  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)

  cart.each do |food, data|
    total += (data[:price] * data[:count]) unless data[:count] == 0
  end

 if total > 100
   total = total * 0.90
end
total

end
