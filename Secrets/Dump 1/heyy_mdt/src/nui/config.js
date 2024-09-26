const formatter = new Intl.NumberFormat('en-US', {
	style: 'currency',
	currency: 'USD',
	minimumFractionDigits: 0,
	maximumFractionDigits: 0,
});

const config = {
	formatMoney: (value) => {
		return formatter.format(value);
	}
}

window.config = config;