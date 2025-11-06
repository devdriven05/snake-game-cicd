import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from game import Snake, Food, Game

def test_snake_initialization():
    snake = Snake()
    assert snake.length == 1
    assert snake.score == 0
    assert snake.positions == [(10, 10)]

def test_snake_movement():
    snake = Snake()
    snake.update()
    assert snake.positions[0] == (11, 10)

def test_snake_grow():
    snake = Snake()
    initial_length = snake.length
    snake.grow()
    assert snake.length == initial_length + 1
    assert snake.score == 10

def test_food_initialization():
    food = Food()
    assert food.position == (5, 5)

def test_game_initialization():
    game = Game()
    assert game.game_over == False
    assert hasattr(game.snake, 'positions')
