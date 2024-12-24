import { add, getTitle, multiply, subtract } from "~/helpers/func";

test("add should return the sum of two numbers", () => {
  expect(add(2, 3)).toBe(5);
});

test("subtract should return the difference of two numbers", () => {
  expect(subtract(5, 3)).toBe(2);
});

test("multiply should return the product of two numbers", () => {
  expect(multiply(2, 3)).toBe(6);
});

test("title should be jenkinks", () => {
  expect(getTitle()).toBe("Jenkins");
});
