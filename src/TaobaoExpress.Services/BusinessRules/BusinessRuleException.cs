﻿namespace TaobaoExpress.Services.BusinessRules
{
    using System;

    public class BusinessRuleException : Exception
    {
        public BusinessRuleException(string message) : base(message)
        {
        }
    }
}
