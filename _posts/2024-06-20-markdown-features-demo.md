---
layout: post
title: "Enhanced Markdown Features Demo"
date: 2024-06-20 15:00:00 +0800
categories: [demo, markdown]
tags: [markdown, syntax, math, code]
---

# Enhanced Markdown Features Demo

This post demonstrates all the enhanced markdown features now available in your hacker-style blog.

## Code Syntax Highlighting

### Python Code
```python
def fibonacci(n):
    """Generate Fibonacci sequence up to n terms."""
    if n <= 0:
        return []
    elif n == 1:
        return [0]
    elif n == 2:
        return [0, 1]
    
    sequence = [0, 1]
    for i in range(2, n):
        sequence.append(sequence[i-1] + sequence[i-2])
    
    return sequence

# Example usage
$$fib_numbers = fibonacci(10)$$
print(f"First 10 Fibonacci numbers: {fib_numbers}")
```

### C++ Code
```cpp
#include <iostream>
#include <vector>
#include <algorithm>

class DataProcessor {
private:
    std::vector<int> data;
    
public:
    void addData(int value) {
        data.push_back(value);
    }
    
    double calculateAverage() const {
        if (data.empty()) return 0.0;
        
        int sum = std::accumulate(data.begin(), data.end(), 0);
        return static_cast<double>(sum) / data.size();
    }
    
    void sortData() {
        std::sort(data.begin(), data.end());
    }
};

int main() {
    DataProcessor processor;
    processor.addData(42);
    processor.addData(17);
    processor.addData(89);
    
    std::cout << "Average: " << processor.calculateAverage() << std::endl;
    return 0;
}
```

### SQL Code
```sql
-- Complex query with CTEs and window functions
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) as month,
        SUM(total_amount) as monthly_total,
        COUNT(*) as order_count
    FROM orders 
    WHERE order_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', order_date)
),
sales_with_growth AS (
    SELECT 
        month,
        monthly_total,
        order_count,
        LAG(monthly_total) OVER (ORDER BY month) as prev_month_total,
        (monthly_total - LAG(monthly_total) OVER (ORDER BY month)) / 
        LAG(monthly_total) OVER (ORDER BY month) * 100 as growth_rate
    FROM monthly_sales
)
SELECT 
    month,
    monthly_total,
    order_count,
    ROUND(growth_rate, 2) as growth_percentage
FROM sales_with_growth
ORDER BY month;
```

### Bash/Shell Code
```bash
#!/bin/bash

# System monitoring script
function check_system_health() {
    echo "=== System Health Check ==="
    
    # Check disk usage
    echo "Disk Usage:"
    df -h | grep -E '^/dev/' | awk '{print $5 " " $1}' | while read output;
    do
$$usage=$(echo $output | awk '{print $1}' | sed 's/%//g')$$
$$partition=$(echo $output | awk '{print $2}')$$
        
        if [ $usage -ge 90 ]; then
            echo "WARNING: $partition is ${usage}% full"
        else
            echo "OK: $partition is ${usage}% full"
        fi
    done
    
    # Check memory usage
    echo -e "\nMemory Usage:"
    free -h | grep '^Mem:' | awk '{print "Used: " $3 "/" $2 " (" $3/$2*100 "%)"}'
    
    # Check CPU load
    echo -e "\nCPU Load:"
    uptime | awk -F'load average:' '{print "Load Average:" $2}'
}

check_system_health
```

## Mathematics Support

### Inline Math
$$Here's an inline equation: $E = mc^2$ and another one: $\sum_{i=1}^{n} x_i = x_1 + x_2 + \cdots + x_n$.$$

### Display Math
Complex mathematical expressions are fully supported:

$$
$$\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}$$
$$

$$
$$\frac{\partial}{\partial t} \Psi(\mathbf{r}, t) = \frac{i\hbar}{2m} \nabla^2 \Psi(\mathbf{r}, t) + V(\mathbf{r}) \Psi(\mathbf{r}, t)$$
$$

### Matrix Equations
$$
\begin{pmatrix}
a & b \\
c & d
$$\end{pmatrix}$$
\begin{pmatrix}
x \\
y
$$\end{pmatrix}$$
=
\begin{pmatrix}
ax + by \\
cx + dy
$$\end{pmatrix}$$
$$

### Statistical Formulas
The probability density function of a normal distribution:

$$
$$f(x|\mu,\sigma^2) = \frac{1}{\sqrt{2\pi\sigma^2}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$
$$

## Advanced Markdown Features

### Tables
| Algorithm | Time Complexity | Space Complexity | Use Case |
|-----------|----------------|------------------|----------|
| Quick Sort | O(n log n) avg | O(log n) | General sorting |
| Merge Sort | O(n log n) | O(n) | Stable sorting |
| Heap Sort | O(n log n) | O(1) | Memory constrained |
| Bubble Sort | O(n²) | O(1) | Educational |

### Task Lists
- [x] Implement syntax highlighting
- [x] Add math support with KaTeX
- [x] Create hacker-style post layout
- [ ] Add dark mode toggle
- [ ] Implement search functionality
- [ ] Add comment system

### Blockquotes
> "The best way to predict the future is to implement it."
> 
> — Alan Kay

> **Note:** This is a multi-line blockquote that demonstrates
> how longer quotes are handled in the hacker theme.
> The styling maintains readability while keeping the cyberpunk aesthetic.

### Links and References
Check out my [GitHub profile](https://github.com/Baymine) for more projects.

You can also reference other posts: [Welcome Post]({% post_url 2024-06-20-welcome-to-my-blog %})

### Images
![Hacker Terminal](https://via.placeholder.com/600x300/0a0a0a/00ff41?text=HACKER+TERMINAL)

### Horizontal Rules
---

## Code with Line Numbers
The syntax highlighting includes line numbers for better readability:

```javascript
// Advanced JavaScript example with async/await
class APIClient {
    constructor(baseURL) {
        this.baseURL = baseURL;
$$this.headers = {$$
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${this.getToken()}`
        };
    }
    
    async get(endpoint) {
        try {
$$const response = await fetch(`${this.baseURL}${endpoint}`, {$$
                method: 'GET',
                headers: this.headers
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            return await response.json();
        } catch (error) {
            console.error('API request failed:', error);
            throw error;
        }
    }
    
    getToken() {
        return localStorage.getItem('authToken') || '';
    }
}

// Usage example
const client = new APIClient('https://api.example.com');
client.get('/users/profile')
    .then(data => console.log('User profile:', data))
    .catch(error => console.error('Failed to fetch profile:', error));
```

## Conclusion

Your blog now supports:
- ✅ **Syntax highlighting** for 100+ programming languages
- ✅ **Mathematical equations** with KaTeX rendering
- ✅ **Enhanced tables** with proper styling
- ✅ **Task lists** and checkboxes
- ✅ **Blockquotes** with proper formatting
- ✅ **Code blocks** with line numbers
- ✅ **Responsive design** that works on all devices
- ✅ **Hacker aesthetic** that matches your homepage

All while maintaining the cyberpunk terminal theme throughout your blog! 🚀
