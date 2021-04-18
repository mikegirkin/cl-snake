(defpackage #:tests/main
  (:use :cl
        :rove
        :snake))

(in-package :tests/main)

(deftest resolve-color
  (testing "resolve-color could resolve literal"
    (ok (equal (list 255 0 0 255) (resolve-color :red))))
  (testing "resolve-color should return nil if there is no such literal color"
    (ok (null (resolve-color :blabla))))

  (testing "resolve-color should return back list if passed with the list"
    (ok (equal (list 255 0 0 255) (resolve-color (list 255 0 0 255)))))

  (testing "resolve-color should return nil if not a list or literal"
    (ok (null (resolve-color "red")))))

