const mongoose = require('mongoose');
const Product = require('../models/product');
const fs = require('fs');

exports.getAllProducts = (req, res, next) => {
	Product
		.find()
		.exec()
		.then(products => {
			const response = {
				count: products.length,
				products: products.map(product => {
					return {
						_id: product._id,
						model: product.model,
						price: product.price,
						productImage: product.productImage,
						colour: product.colour,
						shape: product.shape,
						materialType: product.materialType,
						stock_left: product.stock_left,
						date: product.date,
						dimensions: product.dimensions,
						gender: product.gender,
						sold: product.sold,
						avgRating: product.avgRating,
						reviews: product.reviews,
						category: product.category
					}
				})
			};
			res.status(200).json(response);
		})
		.catch(error => {
			next(error);
		})
};

exports.createOneProduct = (req, res, next) => {
	const product = createProduct(req);

	product
		.save()
		.then(product => {
			res.status(200).json({
				message: 'Product Created Successfully!',
				product: {
					_id: product._id,
					model: product.model,
					price: product.price,
					productImage: product.productImage,
					colour: product.colour,
					shape: product.shape,
					materialType: product.materialType,
					stock_left: product.stock_left,
					date: product.date,
					dimensions: product.dimensions,
					gender: product.gender,
					sold: product.sold,
					avgRating: product.avgRating,
					reviews: product.reviews,
					category: product.category
				}
			});
		})
		.catch(error => {
			console.log(error);
			next(error);
		});
};

exports.getOneProduct = (req, res, next) => {
	const id = req.params.productId;
	Product
		.findById(id)
		.select('_id price model category productImage colour shape materialType stock_left date dimensions gender sold avgRating reviews')
		.exec()
		.then(product => {
			if (product) {
				res.status(200).json(product);
			}
			else {
				res.status(404).json({
					message: 'Product Not Found!'
				});
			}
		})
		.catch(error => {
			next(error);
		});
};

exports.getCategoryProduct = (req, res, next) => {
	const category = req.params.categoryType;
	Product
		.find({category: category})
		.select('_id price model category productImage colour shape materialType stock_left date dimensions gender sold avgRating reviews')
		.exec()
		.then(product => {
			if (product) {
				res.status(200).json(product);
			}
			else {
				res.status(404).json({
					message: 'Product Not Found!'
				});
			}
		})
		.catch(error => {
			next(error);
		});
};

exports.updateOneProduct = (req, res, next) => {
	const productId = req.params.productId;

	Product
		.update({ _id: productId }, { $set: req.body })
		.exec()
		.then(result => {
			res.status(200).json({
				message: 'Updated Product Successfully!',
				result: result
			});
		})
		.catch(error => {
			next(error);
		})
};

exports.deleteOneProduct = (req, res, next) => {
	const productId = req.params.productId;
	Product.findOne({_id: productId}).exec().then(result => {
		fs.unlink(result.productImage, (err) => {
			if(err) {console.log(err);}
			else {console.log("Deleted " + result.productImage);}
		});
	});
	Product
		.remove({ _id: productId })
		.exec()
		.then(result => {
			res.status(200).json({
				message: 'Deleted Product Successfully!',
				result: result
			});
		})
		.catch(error => {
			next(error);
		});
};

function createProduct(req) {
	return new Product({
		_id: new mongoose.Types.ObjectId(),
		model: req.body.model,
		price: req.body.price,
		productImage: req.file.path,
		dimensions: req.body.dimensions,
		gender: req.body.gender,
		colour: req.body.colour,
		shape: req.body.shape,
		materialType: req.body.materialType,
		stock_left: req.body.stock_left,
		sold: req.body.sold,
		avgRating: req.body.avgRating,
		reviews: req.body.reviews,
		category: req.body.category
	});
}
