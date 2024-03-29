const router = require('express').Router();
const ctrl = require('./auth.controller');
const { loginSchema, registerSchema, emailSchema, verifyOtpSchema } = require('./auth.validations');
const { validateRequestMiddleware } = require('../../shared/middleware');

router.post('/login', validateRequestMiddleware('body', loginSchema), ctrl.handleLogin);
router.post('/register', validateRequestMiddleware('body', registerSchema), ctrl.handleRegister);
router.post(
  '/forgot-password',
  validateRequestMiddleware('body', emailSchema),
  ctrl.handleForgotPassword,
);
router.post('/resend-otp', validateRequestMiddleware('body', emailSchema), ctrl.handleResendOtp);
router.post(
  '/verify-otp',
  validateRequestMiddleware('body', verifyOtpSchema),
  ctrl.handleVerifyOtp,
);

module.exports = router;
