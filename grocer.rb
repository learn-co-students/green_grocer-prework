require 'pry'
def consolidate_cart(cart)
consolidated = {}
  cart.each do |items|
    items.each do |item, info|
      if consolidated[item] == nil
        consolidated[item] = info
        consolidated[item][:count] = 1
      else
        consolidated[item][:count] += 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  cart.each do |item, info|
    coupons.each do |discount|
      if discount[:item] == item && cart["#{item} W/COUPON"] == nil && cart[item][:count] >= discount[:num]
        coupon_num_applied = discount[:num]
        cart[item][:count] -= coupon_num_applied
        cart = cart.dup
        cart["#{item} W/COUPON"] = {
          price: discount[:cost],
          clearance: cart[item][:clearance],
          count: 1
        }
      elsif discount[:item] == item && cart[item][:count] >= discount[:num]
        num_applied = discount[:num]
        cart[item][:count] -= num_applied
        cart["#{item} W/COUPON"][:count] += 1
      end
    end
  end
  cart
end
=begin
#### The `apply_coupons` method

If the method is given a cart that looks like this:

```ruby
{
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}
```
and a coupon for avocados that looks like this:

```ruby
{:item => "AVOCADO", :num => 2, :cost => 5.0}

```

then `apply_coupons` should return the following hash:

```ruby
{
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 1},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1},
  "AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1},
}
```

Notice how there were three avocados in the cart, but the coupon only applied to two of them.
This left one un-couponed avocado in the cart at $3.00 and one "bundle" of discounted avocados totalling $5.00.
=end

def apply_clearance(cart)
cart.each do |item, info|
  if info[:clearance] == true
    new_price = info[:price] * 0.8
    info[:price] = new_price.round(2)
  end
end
cart
end
=begin
This method should discount the price of every item on clearance by twenty percent.

For instance, if this method was given this cart:

```ruby
{
  "PEANUTBUTTER" => {:price => 3.00, :clearance => true,  :count => 2},
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3}
  "SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1}
}
```

it should return a cart with clearance applied to peanutbutter and soy milk:

```ruby
{
  "PEANUTBUTTER" => {:price => 2.40, :clearance => true,  :count => 2},
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3}
  "SOY MILK"     => {:price => 3.60, :clearance => true,  :count => 1}
}
=end

def checkout(cart, coupons)
cart = consolidate_cart(cart)
cart = apply_coupons(cart, coupons)
cary = apply_clearance(cart)
total = 0
  cart.each do |item, info|
    total += info[:price] * info[:count]
  end
  if total > 100
    total = total * 0.9
  end
total
end
