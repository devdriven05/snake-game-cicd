class Snake:
    def __init__(self):
        self.positions = [(10, 10)]
        self.direction = (1, 0)
        self.length = 1
        self.score = 0
    
    def get_head_position(self):
        return self.positions[0]
    
    def update(self):
        head = self.get_head_position()
        x, y = self.direction
        new_position = ((head[0] + x) % 20, (head[1] + y) % 20)
        
        if new_position in self.positions[1:]:
            return False
            
        self.positions.insert(0, new_position)
        if len(self.positions) > self.length:
            self.positions.pop()
            
        return True
    
    def grow(self):
        self.length += 1
        self.score += 10
    
    def change_direction(self, direction):
        if (direction[0] * -1, direction[1] * -1) != self.direction:
            self.direction = direction

class Food:
    def __init__(self):
        self.position = (5, 5)
    
    def randomize_position(self, snake_positions=None):
        if snake_positions is None:
            snake_positions = []
        self.position = (15, 15)

class Game:
    def __init__(self):
        self.snake = Snake()
        self.food = Food()
        self.game_over = False
