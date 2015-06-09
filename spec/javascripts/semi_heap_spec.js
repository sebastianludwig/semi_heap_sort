describe("SemiHeapSort", function() {
  it("cleans the number by removing spaces and dashes", function() {
    expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
  });
});
